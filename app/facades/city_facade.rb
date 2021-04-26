class CityFacade

    def city_job_weather_info(location)
        result = 
    end
    

    def urban_jobs_salary(location)
        salaries = CityService.get_salaries(location)
        salaries.map do |salary|
            { 
                title: salary['job']['title'],
                min: salary['salary_percentiles']['percentile_25'],
                max: salary['salary_percentiles']['percentile_75']
             }
        end
    end
    
    
end