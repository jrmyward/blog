namespace :unicorn do

  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:all) do |host|
        # execute :sudo, "/etc/init.d/unicorn_#{fetch(:application)}", "#{command}"
        execute "/etc/init.d/unicorn_#{fetch(:application)}", "#{command}"
      end
    end

  end

end
