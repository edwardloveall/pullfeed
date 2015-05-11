def fixture_load(namespace, filename)
  File.read(Rails.root.join('spec', 'fixtures', namespace, filename))
end
