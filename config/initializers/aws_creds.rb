module AwsCreds

  def self.access_key_id
    if Rails.env.production?
      ENV['AWS_ACCESS_KEY_ID']
    else
      Secrets.aws_access_key_id
    end
  end

  def self.secret_access_key
    if Rails.env.production?
      ENV['SECRET_ACCESS_KEY']
    else
      Secrets.aws_secret_access_key
    end
  end

  def self.bucket_name
    if Rails.env.production?
      ENV['BUCKET_NAME']
    else
      Secrets.bucket_name
    end
  end

end


