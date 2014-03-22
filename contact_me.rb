require "sinatra"
require "data_mapper"
require "./Contact.rb"
require "pony"

#####
#GET
#####

#show the contact form
get "/" do
  erb :index, layout: :default_template
end

get "/view_all" do
  erb :view_all, layout: :default_template
end

######
#POST
######

post "/" do
  #email myself the information
  Pony.mail(:to => 'nigel.kehler@gmail.com', :from => 'nigel.kehler@gmail.com', :subject => 'New contact', :body => '#{params[:address]} #{params[:department]} #{params[:message]}')

  #create the contact in the database
  Contact.create(name: params[:name], address: params[:address],
        department: params[:department], message: params[:message])
  #show the contacts
  @status_message = "Contact added!"
  @contacts_sales = Contact.all(:department => 'sales')
  @contacts_marketing = Contact.all(:department => 'marketing')
  @contacts_technical = Contact.all(:department => 'technical')
  erb :view_all, layout: :default_template
end 