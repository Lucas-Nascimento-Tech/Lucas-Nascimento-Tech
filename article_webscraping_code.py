'''
So, for this exercise I used a specific URL and the code was created based on its website HTML.
Therefore, unfortunately this code cannot be used in any other website.
'''

# Lets use requests for extracting web content and BeautifulSoup for parsing it
import requests as requests
from bs4 import BeautifulSoup


# function to receive any URL
def get_article(url):

    #Load page
    page = requests.get(url).text
    data = BeautifulSoup(page, 'html.parser')

    #scrapping page information
    
    title = data.find('h1') #Starting from the title, of course :)
    for h1 in title:
        print(f'Title: {title.text}')

    date = data.find('time') #date that the article was written
    for time in date:
        print(f'Date: {date.text}')
    
    #Getting to know who wrote the article
    finding_div_tag = data.find("div", class_="single__author-info") #Findig div tag first
    finding_span_tag = finding_div_tag.find("span", class_="typography__body--5") #finding span tag
    text = finding_span_tag.get_text(separator=" ", strip=True) #To finally getting the author text we want 
    print(f'Author {text}')

    #Extracting content
    content_div_tag = data.find('div', class_='single__content')
    disclaimer_div_tag = content_div_tag.find('div', class_="single__disclaimer")
    disclaimer_div_tag_content = disclaimer_div_tag.get_text(separator=" ", strip=True)
    print(f"Disclaimer: '\n' {disclaimer_div_tag_content}") #printing disclaimer first

    elementb_div_tag = content_div_tag.find('div', class_="element-border--bottom spacing--pb4")
    content_text = elementb_div_tag.get_text(separator=" ", strip=True)
    print(f"Content: '\n' {content_text}") #Now for the rest of the content

#Function testing
get_article('https://www.infomoney.com.br/colunistas/convidados/de-faamg-para-sete-maravilhas-ou-quarteto-fantastico-afinal-as-big-techs-estao-mesmo-caras/')

