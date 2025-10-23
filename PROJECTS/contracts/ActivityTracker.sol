// Create a smart contract that logs user workouts and emits events when fitness goals are reached — like 10 workouts in a week or 500 total minutes.
// Users log each session (type, duration, calories), and the contract tracks progress. Events use *indexed* parameters to make it easy for frontends or
// off-chain tools to filter logs by user and milestone — just like a backend for a decentralized fitness tracker with achievement unlocks.
// # Concepts You'll Master
// 1. Events
// 2. logging data
// 3. Indexed parameters
// 4. emitting events

//Logs user workouts(10 workouts/weeks,500mins) user log sesion type,udration,calories, emits events when goal completed,focus on indexed parameters
contract A{
struct User {
    string name;
    uint duration_;
    uint workouts_;
    uint calr_;
    string[] workoutTypes_;
}

mapping(address=> User)info;
mapping(address => mapping(bytes32 => bool)) public milestoneReached;

event Workout(
    address indexed user,         
    bytes32 indexed milestone,     
    string milestoneName,        
    string[] workoutTypes,            
    uint duration,                 
    uint calr                   
);

function logWorkout(string memory workoutType, uint duration, uint calories) public {
    info[msg.sender].duration_ += duration;
    info[msg.sender].workouts_ += 1;
    info[msg.sender].calr_ += calories;
    info[msg.sender].workoutTypes_.push(workoutType);

    if(info[msg.sender].duration_ >= 500 && !milestoneReached[msg.sender]["Duration500"]) {
        milestoneReached[msg.sender]["Duration500"] = true;
        emit Workout(msg.sender, "Duration500", "500 minutes reached!", info[msg.sender].workoutTypes_, info[msg.sender].duration_, info[msg.sender].calr_);
    }
    if(info[msg.sender].duration_ > 500 && info[msg.sender].duration_ < 1000 && !milestoneReached[msg.sender]["DurationHalf"]) {
        milestoneReached[msg.sender]["DurationHalf"] = true;
        emit Workout(msg.sender, "DurationHalf", "Halfway to 1000 minutes!", info[msg.sender].workoutTypes_, info[msg.sender].duration_, info[msg.sender].calr_);
    }
    if(info[msg.sender].duration_ >= 1000 && !milestoneReached[msg.sender]["Duration1000"]) {
        milestoneReached[msg.sender]["Duration1000"] = true;
        emit Workout(msg.sender, "Duration1000", "1000 minutes achieved!", info[msg.sender].workoutTypes_, info[msg.sender].duration_, info[msg.sender].calr_);
    }

    if(info[msg.sender].workouts_ >= 10 && !milestoneReached[msg.sender]["Workouts10"]) {
        milestoneReached[msg.sender]["Workouts10"] = true;
        emit Workout(msg.sender, "Workouts10", "10 workouts completed!", info[msg.sender].workoutTypes_, info[msg.sender].duration_, info[msg.sender].calr_);
    }

    if(info[msg.sender].calr_ >= 2000 && !milestoneReached[msg.sender]["Calories2000"]) {
        milestoneReached[msg.sender]["Calories2000"] = true;
        emit Workout(msg.sender, "Calories2000", "2000 calories burned!", info[msg.sender].workoutTypes_, info[msg.sender].duration_, info[msg.sender].calr_);
    }
}
}
