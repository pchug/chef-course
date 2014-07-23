search("users", "*:*").each do |user_data|
 user user_data["id"] do
   comment user_data["comment"]
   uid user_data["uid"]
   gid user_data["gid"]
   home user_data["home"]
   shell user_data["shell"]
 end
end

# this command actually inserts the mentioned cookbook right
# here. This is functionally different from the "depends" command in
# the metadata.rb-- which doesn't run those recipes. "depends" lets
# the cookbook use the attributes from the dependee cookbook

include_recipe "users::groups"
