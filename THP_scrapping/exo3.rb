require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'HTTParty'

def get_info_about_incubators(lien)

    page = Nokogiri::HTML(open(lien))
    number_of_pages = page.css('div.nav-links > a.page-numbers:nth-last-child(-n+2)')
    # Pour connaitre la dernière page = récupération des deux dernier élément de la pagination (dernière page et suivant)
    last_page = []
        
    number_of_pages.each { |info|
        page = info.text
        last_page.push(page)
    }
    # Ces deux élément sont pushé dans un array pour ne garder que le dernier numéro de page juste après.
    x = last_page[0]
    start = 1
    stop = x.to_i  
    # On garde le dernier numéro de page pour construire un range

    url = ""
    incubator_names = []
    (start..stop).each { |a|
        if a == 1
            url = lien
        else 
            url = lien + "page/#{a}/"
        end
    # Pour la page 1, on garde la lien initial, pour les autres, on prend le lien initial auquel on ajoute page/a/ à chaque boucle pour réspecter le format des urls

        pages = HTTParty.get(url)
        website_pages = Nokogiri::HTML(pages)
    # On construit les nouveaux liens pour chaque page de l'annuaire et on ne garde que l'élément qui nous intéresse, les pages des incubateurs.
        incubator_pages = website_pages.css('h2.listing-row-title > a')
            incubator_pages.each { |page|
                incubator_name = page.text
                incubator_webpage = page['href']
                incub_contact = Hash[incubator_name => incubator_webpage]
                incubator_names.push(incub_contact)
                # Ici on prend le nom de l'incubateur + sa webpage sur alloweb et on le met dans un hash. 
                # On push chaque hash dans un array
            }
        
        print incubator_names
        # incubator_website = 
        # et ici on essaye de récupérer le site internet de l'incubateur... à suivre!                 
    }    
end

def perform
    lien = "http://www.alloweb.org/annuaire-startups/base-de-donnees-startups/annuaire-incubateurs-de-startups/"
    get_info_about_incubators(lien)
end

perform

