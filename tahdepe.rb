# encoding: utf-8

require 'rubygems'
require 'sinatra'
require './busca_info.rb'

get '/' do
  %Q{
  <h1>tah de pé??</h1>

  <p>escolha uma máquina e confira o status do JBoss</p>

  <ul>
    <li><a href="/danger4">danger4</a></li>
    <li><a href="/danger1">danger1</a></li>
  </ul>
  }
end

get '/:machine' do
  busca = BuscaInfo.new params[:machine]
  servers = busca.lista_status

  saida = ""

  servers.each do |serv|
    item = "<li><span>#{serv[:server]}:</span> #{serv[:status]}</li>"
    saida << item
  end

  %Q{
    <h1>#{params[:machine]}</h1>
	
    
    <ul>
    #{saida}
    </ul>

    <a href="/">voltar</a>
  } 
end
