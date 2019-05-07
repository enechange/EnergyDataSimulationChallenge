include_recipe './recipes/apt_get_update'
include_recipe './recipes/apt_get_install'

include_recipe './recipes/locale'
include_recipe './recipes/add_new_user'
include_recipe './recipes/sudoers'
include_recipe './recipes/zsh'
include_recipe './recipes/ssh_keys_config'

include_recipe './recipes/rbenv'
include_recipe './recipes/ruby'

include_recipe './recipes/mysql_server'
include_recipe './recipes/openjdk_8_jre'
include_recipe './recipes/embulk'
include_recipe './recipes/nginx'
