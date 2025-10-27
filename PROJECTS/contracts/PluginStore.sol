// Build a modular profile system for a Web3 game. The core contract stores each player's basic profile (like name and avatar), but players can activate
//  optional 'plugins' to add extra features like achievements, inventory management, battle stats, or social interactions. Each plugin is a separate 
//  contract with its own logic, and the main contract uses `delegatecall` to execute plugin functions while keeping all data in the core profile. This 
//  allows developers to add or upgrade features without redeploying the main contract—just like installing new add-ons in a game. You'll learn how to use 
//  `delegatecall` safely, manage execution context, and organize external logic in a modular way.

// # Concepts you will master
// 1. delegatecall
// 2. code execution context
// 3. libraries


contract PlayersDetails{
    struct profile{
        uint id,
        string name,
        string avatar,
        uint256 level,
        mapping(string => bool) activePlugins;
    }
    PlayersDetails[] public player;

  function activatePlugin(uint _playerId, string memory _pluginName) public {
        uint idx = playerIdToIndex[_playerId];
        player[idx].activePlugins[_pluginName] = true;
    }

        function DelegateCall(
        address contractAddress, 
        string memory funcName, 
        bytes memory args
    ) public {
        (bool success, bytes memory data) = contractAddress.delegatecall(
            abi.encodePacked(
                bytes4(keccak256(bytes(funcName))),
                args
            )
        );
        require(success, "Delegatecall failed");
    }

}

contract Achievements {
    string public achievementName;

    function setAchievement(string memory _name) public {
        achievementName = _name;
    }
}

contract Inventory {
    uint public itemCount;

    function addItem() public {
        itemCount += 1;
    }
}

contract Management {
    address public manager;

    function setManager(address _manager) public {
        manager = _manager;
    }
}

contract BattleStats {
    uint public battlesWon;

    function winBattle() public {
        battlesWon += 1;
    }
}

contract SocialInteractions {
    uint public friends;

    function addFriend() public {
        friends += 1;
    }
}
