Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = { :bucket => AwsCreds.bucket_name,
    :access_key_id => AwsCreds.access_key_id,
    :secret_access_key => AwsCreds.secret_access_key 
    }
