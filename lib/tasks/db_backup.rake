namespace :db do
  desc "mysql dump: db backup to Amazon S3"

  task :backup => :environment do
    # mysql dumpしてs3cmd でs3に送信
    # s3cmd put 20140105-mameblo-mysql.dump s3://mameblo-backup/2014/01/
    system "mysqldump -u #{ENV['SQALE_USERNAME']} -h #{ENV['SQALE_HOST']} -p #{ENV['SQALE_DATABASE']} --password=#{ENV['SQALE_PASSWORD']} > #{Time.now.strftime('%Y%m%d')}-mameblo-mysql.dump"

    system "s3cmd put ./tmp/#{Time.now.strftime('%Y%m%d')}-mameblo-mysql.dump s3://mameblo-backup/#{Time.now.year}/#{Time.now.month}/"
  end
end
