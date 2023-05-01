class Seat < ApplicationRecord
	enum :status, { free: 0, reserved: 1, selected: 2 }
end