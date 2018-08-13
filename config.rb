activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :sprockets

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :relative_assets
  set :relative_links, true
end

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.deploy_method = :git
end


# Blog setup
activate :blog do |blog|
  blog.sources = "jobs/{year}-{month}-{day}-{title}.html"
  blog.permalink = "jobs/{year}/{company_name}/{title}.html"
  blog.layout = "jobs_md"
end

# Jobs Archives - Dynamic pages generation
data.jobs.each do |job|
  proxy "/jobs-archive/#{job.id}.html", "/jobs_templates/template_jobs.html", locals: { selected_job: job }, ignore: true
end

activate :livereload
activate :directory_indexes