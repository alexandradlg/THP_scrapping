require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_currencies_exchange_each_hour(lien)

    page = Nokogiri::HTML(open(lien))
    name = page.css('a.currency-name-container')
    price_info = page.css('a.price')
    names = []
    prices = []
    crypto = []

    loop do

        # boucle de répétition du programme toutes les heures 

        name.each { |element|
            currency = element.text    
            names.push(currency)
            # récupration du symbol de la cryptomonnaie et ajout à un array
        }
        price_info.each { |element|
            price = element['data-usd']
            prices.push(price)
            # Récupération du cours de la cryptomonnaie et ajout à un array
        }

        crypto_hash= {}
        names.zip(prices) {|a,b| crypto_hash[a] = b }
        # Création d'un hash avec les deux array
        crypto_hash.each { |key, value|
            my_hash = Hash[key => value]
            # Découpage en hash par cryptomonnaie/cours
            crypto.push(my_hash)
            # Ajout de chaque hash à un array pour arriver à avoir un array de hashs
        }
    
        print crypto
        sleep 3600
        # Et ça recommence dans 1h!
    end
end


def perform
    lien = "https://coinmarketcap.com/all/views/all/"
    get_currencies_exchange_each_hour(lien)
end

perform

    

   



    

