pragma solidity >=0.7.0 <0.9.0;

contract CycleProject{
    
    uint256  manufacturer_id_count = 0;
    uint256  cycle_id=0;
    uint256  part_id = 0;
    uint256  ownership_id = 0;
    uint256  location_id = 0;
    mapping (uint256=> cycle) public id_to_cycle;
    mapping (uint256=> part) public id_to_part;
    
    mapping (uint256=> location) public id_to_location;
    
    mapping (uint256=> manufacturer) public id_to_manufacturer;
    mapping (uint256=> owner) public id_to_owner;
    
    struct owner{
        uint256 owner_id;
        string owner_name;
        uint256 location_id;
    }
    struct manufacturer{
        uint256 ownership_id;
        
        uint256 manufacturer_id;
        string manufacturer_name;
        
    }
    
    struct part {
        uint256 part_id;
        string part_name;
        uint256 manufacturer_id;
        uint256 owner_id;
    }
    
    struct location{
                uint256 location_id;
        string location_name;

    }
    struct cycle{
        uint256 cycle_id;
        
        uint256 tyre_1;
        uint256 tyre_2;
        uint256 seat;
        uint256 pedal_1;
        uint256 pedal_2;
        uint256 steering;
        uint256 gear_1;
        uint256 gear_2;
        
    }
    
    function all_parts_valid (        
        uint256 tyre_1,
        uint256 tyre_2,
        uint256 seat,
        uint256 pedal_1,
        uint256 pedal_2,
        uint256 steering,
        uint256 gear_1,
        uint256 gear_2)  private returns(bool) {
            
            if (tyre_1 > 0 && tyre_2 > 0  && seat > 0  && pedal_1 > 0  && pedal_2 > 0  && steering > 0 && gear_1 > 0 && gear_2 > 0 ){
                return true;
            }
            return false;
        
    }
    
    function create_cycle(        
        uint256 tyre_1,
        uint256 tyre_2,
        uint256 seat,
        uint256 pedal_1,
        uint256 pedal_2,
        uint256 steering,
        uint256 gear_1,
        uint256 gear_2
        ) public payable returns(bool) {
        
        require(all_parts_valid(tyre_1,tyre_2,seat,pedal_1,pedal_2,steering,gear_1,gear_2));
         
         cycle_id +=1;
         
         cycle memory new_cycle = cycle(
         cycle_id,
         tyre_1,
         tyre_2,
         seat,
         pedal_1,
         pedal_2,
         steering,
         gear_1,
         gear_2
         );
         
         id_to_cycle[cycle_id] = new_cycle;
         
         return true;
    }
    
    function create_part(string memory part_name, uint256 manufacturer_id) public payable returns (bool) {
        require (manufacturer_id >0);
        part_id +=1;
        part memory new_part = part(part_id, part_name, manufacturer_id,manufacturer_id);
        
        id_to_part[part_id] = new_part;
        return true;
    }
    
    function create_manufacturer(string memory manufacturer_name, uint256 lcoation_id) public payable returns (bool) {
        ownership_id+=1;
        manufacturer_id_count +=1;
        manufacturer memory new_manufacturer = manufacturer(ownership_id, manufacturer_id_count, manufacturer_name);
        owner memory new_owner = owner(ownership_id, manufacturer_name, lcoation_id );
        id_to_manufacturer[manufacturer_id_count] = new_manufacturer;
        id_to_owner[ownership_id] = new_owner;
        return true;
    }
    
    function create_owner(string memory owner_name, uint256 location_id) public payable returns (bool) {
        ownership_id+=1;

        owner memory new_owner = owner(ownership_id,owner_name, location_id);
        
        id_to_owner[ownership_id] = new_owner;
        return true;
    }
    
    
    function create_location(string memory location_name) public payable returns (bool) {
        location_id+=1;

        location memory new_location = location(location_id,location_name);
        
        id_to_location[location_id] = new_location;
        return true;
    }
    
    
    function transfer_ownership(uint256 part_id, uint256 owner_id) public payable returns(bool) {
        id_to_part[part_id].owner_id = owner_id;
        return true;
    }
    
    
}