module FirstOrBuild
  def first_or_build(attributes = nil, &block)
    where(attributes).first || scoping { proxy_association.build(attributes, &block) }
  end
end
