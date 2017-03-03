require("spec_helper")

  describe(Brand) do

    describe(".all") do
      it("starts off with no brand") do
        expect(Brand.all()).to(eq([]))
      end
    end

    describe(".find") do
      it("returns a brand by its ID number") do
        test_brand = Brand.new({:name => "Levis", :id => nil})
        test_brand.save()
        test_brand2 = Brand.new({:name => "Luis Vuitton", :id => nil})
        test_brand2.save()
        expect(Brand.find(test_brand2.id())).to(eq(test_brand2))
      end
    end

    describe("#==") do
      it("is the same brand if it has the same name and id") do
        brand = Brand.new({:name => "Levis", :id => nil})
        brand2 = Brand.new({:name => "Levis", :id => nil})
        expect(brand).to(eq(brand2))
      end
    end

    describe("#update") do
      it("lets you update brands in the database") do
        brand = Brand.new({:name => "Levis", :id => nil})
        brand.save()
        brand.update({:name => "Luis Vuitton"})
        expect(brand.name()).to(eq("Luis Vuitton"))
      end
    end

    describe("#delete") do
      it("lets you delete a brand from the database") do
        brand = Brand.new({:name => "Levis", :id => nil})
        brand.save()
        brand2 = Brand.new({:name => "Luis Vuitton", :id => nil})
        brand2.save()
        brand.delete()
        expect(Brand.all()).to(eq([brand2]))
      end
    end

  end
