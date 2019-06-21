namespace :vue_admin do
  task before: :environment do
    system('echo "before assets:precompile"')
  end

  task build: :environment do
    admin_path = Rails.root.join('vendor/admin')
    public_path = Rails.root.join('public')
    cmd = []
    cmd << "cd #{admin_path} && yarn build"
    cmd << "cp -Rf #{admin_path.join('dist/*')} #{public_path}"
    system(cmd.join(" && "))
  end
end

Rake::Task['assets:precompile'].enhance ['vue_admin:before'] do
  Rake::Task['vue_admin:build'].invoke
end