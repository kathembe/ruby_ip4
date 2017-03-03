class Store

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_stores = DB.exec("SELECT * FROM stores;")
    stores = []
    returned_stores.each() do |store|
      name = store.fetch("name")
      id = store.fetch("id").to_i()
      stores.push(Store.new({:name => name, :id => id}))
    end
    stores
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM stores WHERE id = #{id};")
    name = result.first().fetch("name")
    Store.new({:name => name, :id => id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stores (name) VALUES ('#{name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_store|
    self.name().==(another_store.name()).&(self.id().==(another_store.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE stores SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stores WHERE id = #{self.id()};")
  end

end
