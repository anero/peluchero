class EmailFormatValidator < ActiveModel::EachValidator
  # This validator tries to add some constraints for emails
  #
  # the address MUST contain one @ character
  # the name part MUST NOT start with white-space, @ or dash and contain alphanumeric, underscore, dash and plus only
  # the host part will be split along dots and the subparts MUST NOT start or end with white-space, @ or dashes and contain unicode alphanumeric and dashes only

  REGEXP_HOST_PART = /\A[\p{L}\p{N}]([\p{L}\p{N}\-]*[\p{L}\p{N}])?\z/
  REGEXP_NAME_PART = /\A[A-Z0-9_+-]+(\.[A-Z0-9_+-]+)*\z/i

  def validate_each(record, attribute, value)
    if value.present?
      if valid_structure?(value)
        add_error(record, attribute) unless valid_name?(value) && valid_host?(value)
      else
        add_error(record, attribute)
      end
    end
  end

  protected

  def valid_structure?(value)
    value.split('@').count == 2
  end

  def valid_name?(value)
    value.split('@')[0] =~ REGEXP_NAME_PART
  end

  def valid_host?(value)
    return false if value.count('@') != 1

    # Split the host part into '.'-delimited segments.
    # The -1 tells `split` not to suppress trailing null fields.
    # This is necessary so we can detect trailing '.'s in our string.
    fragments = value.split('@')[1].split('.', -1)
    if fragments.many?
      fragments.all? { |s| s =~ REGEXP_HOST_PART }
    else
      false
    end
  end

  def add_error(record, attribute)
    record.errors[attribute] << (options[:message] || I18n.t('errors.messages.email_not_valid'))
  end
end
