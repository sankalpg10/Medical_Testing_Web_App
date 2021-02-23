class KitidTracker < ApplicationRecord
#  attr_accessor :kit_group, :study, :clave

# call method if you need a unique kit id to be generated
# values passed as parameters are boolean for referrals from doctor/telehealth and distributor

  def generate_kit_id(dc_referral, tl_referral, dt_referral)
    kit_id_return = ""
    # Get the patient kit associated with the order
    @patient_kit = PatientKit.where(kit_group: self.kit_group, study: self.study).first

    # Get all the kit ids already generated for this kit.
    # The kit ids can begin with DT-XXXX or DC-XXXXX or PP-XXXX or TL-XXXXX
    @kit_trackers = KitidTracker.where(clave: @patient_kit.clave)

    # if no such entries exist, call method to generate a new id
    if @kit_trackers.count == 0
      self.clave = @patient_kit.clave
      kit_id_return = generate_new_id dc_referral, tl_referral, dt_referral

      #if entries do exist, call method to check if kit id already exists.
    else
      kit_id_return = generate_new_existing_id dc_referral, tl_referral, dt_referral
    end

    #return kit id generated from sub routines
    kit_id_return
  end

  #Subroutine called from generate_kit_id
  def generate_new_existing_id(dc_referral, tl_referral, dt_referral)
    check_presence = false
    new_id = ""

    # iterate over each kit id tracker row obtained for one specific clave and check if the prefix we want exists already
    @kit_trackers.each do |k|
    split_result = k.kit_id.split("-")

    #condition for doctors
    if split_result[0].to_s == "DC" && dc_referral == true
      new_identifier = increment_identifier split_result
      k.identifier = new_identifier
      new_id = increment_kit_id split_result, k.identifier
      k.kit_id = new_id
      if k.save
        k.kit_id
      else
        LabULog.error "Error in saving newly generated Kit ID in Kit ID Tracker table. ID - " + k.kit_id
      end
      check_presence = true

      #condition for distributor
    elsif split_result[0].to_s == "DT" && dt_referral == true
        new_identifier = increment_identifier split_result
        k.identifier = new_identifier
        new_id = increment_kit_id split_result, k.identifier
        k.kit_id = new_id
        if k.save
          k.kit_id
        else
          LabULog.error "Error in saving newly generated Kit ID in Kit ID Tracker table. ID - " + k.kit_id
        end
        check_presence = true

      #condition for telehealth
    elsif split_result[0].to_s == "TL" && tl_referral == true
        new_identifier = increment_identifier split_result
        k.identifier = new_identifier
        new_id = increment_kit_id split_result, k.identifier
        k.kit_id = new_id
        if k.save
          k.kit_id
        else
          LabULog.error "Error in saving newly generated Kit ID in Kit ID Tracker table. ID - " + k.kit_id
        end
        check_presence = true

      #conditions for PP-XXXX type kit id
    elsif split_result[0].to_s == "PP" && dc_referral == false && tl_referral == false && dt_referral == false
        new_identifier = increment_identifier split_result
        k.identifier = new_identifier
        new_id = increment_kit_id split_result, k.identifier
        k.kit_id = new_id
        if k.save
          k.kit_id
        else
          LabULog.error "Error in saving newly generated Kit ID in Kit ID Tracker table. ID - " + k.kit_id
        end
        check_presence = true
    end
    end

    #check_presence is a flag used to check if the kit id has been generated in the previous iterations
    # if it hasn't, then we generate a new kit id using an existing method

    if !check_presence
      self.clave = @patient_kit.clave
      new_id = generate_new_existing_id dc_referral, tl_referral, dt_referral
    end
    new_id
 end

  # Increment the kit id by appending identifier
  def increment_kit_id(split_result, identifier)
    kit_id = split_result[0] + "-" + split_result[1] + "-" + identifier
  end

  #increment kit id by incrementing the identifier by one
  def increment_identifier(split_result)
    new_id = split_result[2].to_i
    new_id += 1
    identifier = new_id.to_s.rjust(9,"0")
  end

  #method to generate a completely new id

  def generate_new_id(dc_referral, tl_referral, dt_referral)
    if dc_referral == true
      self.identifier = "000000001"
      self.kit_id = "DC-" + self.clave + "-" + self.identifier
    elsif tl_referral == true
      self.identifier = "000000001"
      self.kit_id = "TL-" + self.clave + "-" + self.identifier
    elsif dt_referral == true
      self.identifier = "000000001"
      self.kit_id = "DT-" + self.clave + "-" + self.identifier
    else
      self.identifier = "000000001"
      self.kit_id = "PP-" + self.clave + "-" + self.identifier
    end
    if self.save
      self.kit_id
    else
      LabULog.error "Error in saving newly generated Kit ID in Kit ID Tracker table. ID - " + self.kit_id
    end
  end
end
