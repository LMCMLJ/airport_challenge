require 'airport'

describe Airport do

  before :each do
    @airport = Airport.new
    @plane = double(:plane)
    @err1 = 'Cannot land in bad weather'
    @err2 = 'Cannot take off in bad weather'
  end

  describe '#accessor' do
    it 'allows read of plane_hangar' do
      expect(@airport.plane_hangar << @plane).to eq [@plane]
    end

    it 'allows write of plane_hangar' do
      @airport.plane_hangar = [@plane, @plane]
      expect(@airport.plane_hangar).to eq [@plane, @plane]
    end

    it 'allows read of weather' do
      expect(@airport.weather).to eq(10)
    end
  end

  describe '#land' do
    it 'adds plane to plane_hangar' do
      @airport.land(@plane)
      expect(@airport.plane_hangar).to eq([@plane])
    end

    it 'lands in good weather' do
      @airport.weather = 2
      @airport.land(@plane)
      expect(@airport.plane_hangar).to eq([@plane])
    end

    it 'does not land in bad weather' do
      @airport.weather = 1
      expect { @airport.land(@plane) }.to raise_error(@err1)
    end

    it 'confirms plane is no longer flying' do
      @airport.land(@plane)
    end

    it 'confirms plane has landed' do
    end
  end

  describe '#takeoff' do
    it 'returns plane from hangar if weather is good' do
      @airport.plane_hangar << @plane
      expect(@airport.takeoff(@plane)).to eq([@plane])
    end

    it 'raises error if weather is bad' do
      @airport.plane_hangar << @plane
      @airport.weather = 1
      expect { @airport.takeoff(@plane) }.to raise_error(@err2)
    end

    it 'confirms plane is flying' do
    end

    it 'confirms plane is no longer in airport' do
    end
  end

  describe '#weather?' do
    it 'returns true if weather is 2' do
      @airport.weather = 2
      expect(@airport.weather?).to eq(true)
    end

    it 'returns false if weather is 1' do
      @airport.weather = 1
      expect(@airport.weather?).to eq(false)
    end
  end
end
