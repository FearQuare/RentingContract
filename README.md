# RentingContract
 A web3 contract to rent a house and keep track of the renting process.
 
# Coding Process
 I developed this contract with Remix IDE, since I'm not that proficient on truffle it might not be work as expected on truffle. The code that I'd uploaded is made with truffle.
 
 In the presentation video I run the code with Remix IDE.
 
 I'm fully aware that this code should be improved and it has a lot of flaws, I'll share my thoughts about the flaws at the "What to Do to Improve" part of this document.
 
# Description of the Code
 owner variable is the variable that which can keep track if the function call made with owner or not.
 
 today variable is the variable that wich can keep track of the day to calculate how long that the renter rented the house.
 
 ## struct Renter:
  This struct has 5 instances and those are:
   1. rentingPrice: to store the rent amount
   2. renterID: to store renters address
   3. increment: to store the legal incrementation value to increment the renters renting price after a year.
   4. startAt: to store when did the renter rented the house
   5. a boolean array named rentTrack: this will track if a transaction is successful at that month or not.
 
 We also have a renter array to store renters
 
 ## addRenter function:
  This function initializes a renter and pushes it into renters array.
  
 ## getRenter function:
  Gets the information of the renter with their array index number.
 
 ## updateRent function:
  Updates the amount of rent if and only if the renter stayed there ower a year.
  !! THIS HAS A FLAW THAT YOU CAN UNLIMITEDLY INCREMENT THE RENTERS RENT WHEN THEY STAYED THERE OWER A YEAR.
  This is an event because blockchain should keep track of those incrementations.
  
 ## payForTheRent function:
  This makes renter to pay the rent and pushes a boolean variable onto the rentTrack array regarding to if the transaction is successful or not.
 
 ## deleteRenter function:
  Owner can delete a renter if they didn't pay the rent of any month.
  
# What to do to Improve
