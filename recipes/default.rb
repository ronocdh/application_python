application 'supersonic' do

  # git will fail when run as root, so blank out the $HOME env var,
  # see http://voorhetnageslacht.wordpress.com/2013/07/19/git-issue-when-running-chef-as-root/
  ENV['HOME'] = ''

  path       '/srv/supersonic'
  owner      'vagrant'
  group      'www-data'
  repository 'https://github.com/ronocdh/supersonic.git'
  revision   'master'
  migrate    false
  packages   ['libpq-dev', 'git-core', 'mercurial', 'python-pip', 'build-essential', 'python-dev' ]

  django do
    packages          ['django']
    requirements      '/vagrant/requirements.txt'

    # Our project already has a settings.py, so don't clobber it.
    # settings_template 'settings.py.erb'
    debug             true

    # Our project doesn't have static assets yet, so don't try to collect them.
    # collectstatic     'build_static --noinput'
    database do
      database 'supersonicdb'
      adapter  'postgresql_psycopg2'
      username 'postgres'
      password 'nowthatswhaticalladb'
    end

    # PostgreSQL server configuration is standalone, doesn't need to connect to a master.
    # database_master_role 'packaginator_database_master'

  end
end
