class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :user
  belongs_to :attraction

  # user meets requirements
  # user doesnt have enough tickets
  # user not tall enough
  # user not tall enought and doesnt have enough tickets
  # updates ticket number
  # updates user nausea

  def take_ride
    enough_tickets, tall_enough = meet_requirements
    if enough_tickets && tall_enough
      start_ride
    elsif tall_enough && !enough_tickets
      "Sorry. " + ticket_warn
    elsif enough_tickets && !tall_enough
      "Sorry. " + height_warn
    else
      "Sorry. " + ticket_warn + " " + height_warn
    end
  end

  # enough tickets
  # is tall enough
  # returns tall enough && enough_tickets
  # using multireturn ruby
  # def multireturn
  #   return ["Hello", "World"]
  # end
  # a, b = multireturn
  # puts "return 1: #{a}"
  # puts "return 2: #{b}"

  def meet_requirements
    enough_tickets, tall_enough = false
    if self.user.tickets >= self.attraction.tickets
      enough_tickets = true
    end
    if self.user.height >= self.attraction.min_height
      tall_enough = true
    end
    return [enough_tickets, tall_enough]
  end

  def start_ride
    updated_happiness = self.user.happiness + self.attraction.happiness_rating
    updated_nausea = self.user.nausea + self.attraction.nausea_rating
    updated_tickets =  self.user.tickets - self.attraction.tickets
    self.user.update(
      :happiness => updated_happiness,
      :nausea => updated_nausea,
      :tickets => updated_tickets
    )
    "Thanks for riding the #{self.attraction.name}!"
  end

  def ticket_warn
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def height_warn
    "You are not tall enough to ride the #{self.attraction.name}."
  end


end
