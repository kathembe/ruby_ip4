require("spec_helper")

  describe(Store) do
    describe("#initialize") do
      it("is initialized with a name") do
        store = Store.new({:name => "Jades", :id => nil})
        expect(store).to(be_an_instance_of(Store))
      end

      it("can be initialized with its database ID") do
        store = Store.new({:name => "Jades", :id => 1})
        expect(store).to(be_an_instance_of(Store))
      end
    end

    describe(".all") do
      it("starts off with no stores") do
        expect(Store.all()).to(eq([]))
      end
    end

    describe(".find") do
      it("returns a store by its ID number") do
        test_store = Store.new({:name => "Jades", :id => nil})
        test_store.save()
        test_store2 = Store.new({:name => "Clads", :id => nil})
        test_store2.save()
        expect(Store.find(test_store2.id())).to(eq(test_store2))
      end
    end

    describe("#==") do
      it("is the same store if it has the same name and id") do
        store = Store.new({:name => "Jades", :id => nil})
        store2 = Store.new({:name => "Jades", :id => nil})
        expect(store).to(eq(store2))
      end
    end

    describe("#update") do
      it("lets you update stores in the database") do
        store = Store.new({:name => "Jades", :id => nil})
        store.save()
        store.update({:name => "Clads"})
        expect(store.name()).to(eq("Clads"))
      end
    end

    describe("#delete") do
     it("lets you delete a store from the database") do
       store = Store.new({:name => "Jades", :id => nil})
       store.save()
       store2 = Store.new({:name => "Clads", :id => nil})
       store2.save()
       store.delete()
       expect(Store.all()).to(eq([store2]))
     end
   end

  end
