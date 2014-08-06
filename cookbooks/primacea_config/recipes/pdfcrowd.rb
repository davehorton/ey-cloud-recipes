node["applications"].each do |app_name, data|

	if ['app master','app'].include? node[:instance_role]
		
		credentials = Chef::EncryptedDataBagItem.load "secrets", app_name

		template "/data/#{app_name}/shared/config/pdfcrowd.json" do
			source "pdfcrowd.json.erb"
			owner node[:owner_name]
			group node[:owner_name]
			mode "0644"
			variables({
				:pdfcrowd_username => 	credentials['pdfCrowd']['username'],
				:pdfcrowd_password => 	credentials['pdfCrowd']['password']
			})
		end
	end
end


