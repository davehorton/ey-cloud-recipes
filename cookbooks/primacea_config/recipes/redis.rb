if ['app_master', 'app', 'solo', 'util'].include?(node[:instance_role])

  redis_instance = node['utility_instances'].find { |instance| instance['name'] == 'redis' }
  
  if redis_instance
    node[:applications].each do |app, data|
      template "/data/#{app}/shared/config/redis.json" do
        source 'redis.json.erb'
        owner node[:owner_name]
        group node[:owner_name]
        mode 0655
        backup 0
        variables({
          :redis_hostname => redis_instance[:hostname]
        })
      end
    end
  end
end