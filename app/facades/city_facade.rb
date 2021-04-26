class CityFacade

    def self.city_job_weather_info(location)
        
        result = OpenStruct.new({ 
            id: nil,
            destination: location,
            forecast: location_weather(location),
            salaries: urban_jobs_salary(location)
         })
    end
    

    def self.urban_jobs_salary(location)
        jobs = ['Data Analyst', 'Data Scientist', 'Mobile Developer', 'QA Engineer', 'Sofware Engineer', 'Systems Administrator', 'Web Developer']
        job_info = []
        salaries = CityService.get_salaries(location)
        jobs.each do |job|
            salaries.map do |salary|
                if job == salary['job']['title']
                    job_info << { 
                        title: salary['job']['title'],
                        min: salary['salary_percentiles']['percentile_25'].to_s.gsub(/[$,]/,'').to_f,
                        max: salary['salary_percentiles']['percentile_75'].to_s.gsub(/[$,]/,'').to_f
                    }
                end
            end
        end
        job_info
    end

     def self.location_weather(location)
        location =  CityService.get_city_info('chicago')['location']['latlon']
        weather_info = WeatherFacade.get_weather(location['longitude'], location['latitude'])
        { 
            summary: weather_info[:current][:weather][0][:description],
            temperature: "#{weather_info[:current][:temp].to_i} F"
         }
    end
    
    
end