namespace :nginx do

  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command do
      on roles(:all) do |host|
        execute :sudo, '/etc/init.d/nginx', "#{command}"
      end
    end
  end

end