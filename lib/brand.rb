class Brand
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_brands = DB.exec("SELECT * FROM brands;")
    brands = []
    returned_brands.each() do |brand|
      name = brand.fetch("name")
      id = brand.fetch("id").to_i()
      brands.push(Brand.new({:name => name, :id => id}))
    end
    brands
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM brands WHERE id = #{id};")
    name = result.first().fetch("name")
    Brand.new({:name => name, :id => id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO brands (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_brand|
    self.name().==(another_brand.name()).&(self.id().==(another_brand.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE brands SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM brands WHERE id = #{self.id()};")
  end
end
