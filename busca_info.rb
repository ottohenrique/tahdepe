# encoding: utf-8

require 'net/ssh'

class BuscaInfo
  def initialize machine
    @machine = machine
  end

  def start_ssh
    @ssh = Net::SSH.start("#{@machine}.ir7.com.br", "usuario", password: 'xxxxx')
  end

  def situacao log
    (log =~ /java -Dprogram\.name=run\.sh/) ? "on" : "off"
  end

  def lista_status
    start_ssh

    servers = [] 

    ['/r7', '/recordoutros', '/recordprogramas'].each do |serv|
      status = @ssh.exec! "ps aux | grep jboss | grep '#{serv} '"
      s = situacao status
      servers << {server: serv, status: s}
    end

    servers
  end
end
