namespace :db do
  desc "mysql dump: db backup to Amazon S3"

  task :backup => :environment do
    # mysql dumpしてs3cmd でs3に送信
    # s3cmd put 20140105-mameblo-mysql.dump s3://mameblo-backup/2014/01/
  end
end
