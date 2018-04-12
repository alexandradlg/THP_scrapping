require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'HTTParty'

def get_info_about_incubators(lien)

    page = Nokogiri::HTML(open(lien))
    number_of_pages = page.css('div.nav-links > a.page-numbers:nth-last-child(-n+2)')
    last_page = []
        
    number_of_pages.each { |info|
        page = info.text
        last_page.push(page)
    }

    incubator_names = []
    x = last_page[0]
    start = 1
    stop = x.to_i  
    url = ""
    (start..stop).each { |a|
        if a == 1
            url = lien
        else 
            url = lien + "page/#{a}/"
        end

        pages = HTTParty.get(url)
        website_pages = Nokogiri::HTML(pages)
        incubator_pages = website_pages.css('h2.listing-row-title > a')
            incubator_pages.each { |page|
                incubator_name = page.text
                incubator_names.push(incubator_name)
            }

        # incubator_website = website_pages.css(a:contains("site Internet")')

         
            print  incubator_names

    }

    
end

def perform
    lien = "http://www.alloweb.org/annuaire-startups/base-de-donnees-startups/annuaire-incubateurs-de-startups/"
    get_info_about_incubators(lien)
end

perform

