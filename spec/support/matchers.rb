RSpec::Matchers.define :authorize do |*args|
  match do |permission|
    expect( permission.allow?(*args) ).to be true
  end
end

RSpec::Matchers.define :allow_param do |*args|
  match do |permission|
    expect( permission.allow_param?(*args) ).to be true
  end
end