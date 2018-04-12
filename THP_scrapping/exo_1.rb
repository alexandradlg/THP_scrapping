require 'rubygems'
require 'nokogiri'
require 'open-uri'


def get_email(lien)
    page = Nokogiri::HTML(open(lien))
    email = page.css('td:contains("@")').text
    name = page.css('div.col-md-12.col-lg-10.col-lg-offset-1 > h1').text
    cityhall_info = Hash[name => email] 
    puts cityhall_info

    # Pour récupérer l'email et la ville de la mairie en question
end

def get_links(lien)

    page = Nokogiri::HTML(open(lien))

    list_url = page.css('a.lientxt')
    array_links = []

    list_url.each { |link| 
        url = link['href'] 
        array_links.push(url)
        # Pour récupérer les urls de chaque mairie depuis la page de l'annuaire
    }
    array_links.each { |href|
        complete_link = URI.join(lien,href).to_s
        # Utilisation de URI pour avoir un lien complet et propre de chaque mairie
        get_email(complete_link)
        # Appel à la méthode précédente de récupération des emails et villes sur les liens scrappés
    }   
end

def perform
    lien = "http://annuaire-des-mairies.com/val-d-oise.html"
    get_links(lien)
end

perform


