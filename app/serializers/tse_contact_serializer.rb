class TseContactSerializer < ActiveModel::Serializer
  attributes :id,
    :name,
    :phone,
    :email,
    :address,
    :company,
    :job_title,
    :regions,
    :technologies,
    :domains

  def regions
    object.tse_regions.pluck(:name)
  end

  def technologies
    object.tse_technologies.pluck(:name)
  end

  def domains
    object.tse_domains.pluck(:name)
  end
end
