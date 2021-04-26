class Api::V1::SalariesController < ApplicationController

    def salaries
        location = params[:destination] if params[:destination].present?
        
    end
    
end
