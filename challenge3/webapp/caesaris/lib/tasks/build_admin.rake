namespace :vue_admin do
  task clean: :environment do
    system('echo "Clean up before assets:precompile"')
    public_path = Rails.root.join('public')
    cmd = []
    cmd << "rm -rf #{public_path.join('precache-manifest.*')}"
    cmd << "rm -rf #{public_path.join('css')}"
    cmd << "rm -rf #{public_path.join('js')}"
    cmd << "rm -rf #{public_path.join('img')}"
    cmd << "rm -rf #{public_path.join('fonts')}"
    system(cmd.join(" && "))
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

Rake::Task['assets:precompile'].enhance ['vue_admin:clean'] do
  Rake::Task['vue_admin:build'].invoke
end