module NbpRates
  
  # sciaga kursy walut z NBP
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def nbp_rates_xml

      url = "http://www.nbp.pl/home.aspx?f=/kursy/kursya.html"
      begin
        html = Net::HTTP.get(URI.parse(url))
        doc = Nokogiri::HTML::Document.parse(html)
        day_rate_url = "http://www.nbp.pl"+doc.xpath('.//p[@class=\'file print_hidden left\']/a').first['href']
        html = Net::HTTP.get(URI.parse(day_rate_url))
        XML::Parser.string(html).parse
      rescue e
        puts e
      end
    end
  end

  # abstrakcyjna klasa dotycząca kursow walut
  class Rate
    attr_accessor :page
    attr_accessor :currencies
    attr_accessor :rates
    attr_accessor :rate_date
    attr_accessor :table

    def to_s
      puts "Kursy walut z dnia : #{self.rate_date}, tabela #{self.table}"
      i = 0
      self.rates.map  do |k,v|
        puts "#{i +=1 }. #{k.keys} #{k.values.first[0]}, #{k.values.first[1]}"
      end
    end
  end

  # kursy walut od nbp
  class Rate::NBP < Rate

    def initialize(xml, currencies=[])
      self.page = xml
      self.currencies = currencies
      self.rates = []
    end

    def get_rates
      count_rates
    end


    protected
    def count_rates()
      #self.page = XML::Parser.string(self.xml_data).parse
      self.rate_date = self.page.find('///data_publikacji').first.content
      self.table = self.page.find('///numer_tabeli').first.content
      self.currencies.each_with_index do |cur,i|
        unless page.find("///pozycja[kod_waluty=\'#{cur}\']").first.nil?
          kurs = page.find("///pozycja[kod_waluty=\'#{cur}\']/kurs_sredni").first.content.gsub(',','.').to_f
          przelicznik = page.find("///pozycja[kod_waluty=\'#{cur}\']/przelicznik").first.content.to_i
          self.rates << {cur.to_sym => [kurs, przelicznik]} #page.find("///pozycja[kod_waluty=\'#{cur}\']").to_a
        end
      end
      {:date => self.rate_date, :rates => self.rates, :table => self.table}
    end
  end
end

