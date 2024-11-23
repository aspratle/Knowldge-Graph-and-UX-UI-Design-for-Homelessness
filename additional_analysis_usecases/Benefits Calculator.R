# Benefits calculator
# TODO: 
# 1. Add state-specific calculations
# 2. Replace placeholders:
#     - Medicaid ($500/person)
#     - Section 8 rent ($1200/month)
#     - Job training value ($300/month)
#     - EITC simplified calculation (15% rate)
library(tidyverse)

check_benefits <- function(annual_income, household_size) {
  base_poverty_line = 15060  #single person household
  extra_person_amount = 5380 #additional household members
  poverty_line = base_poverty_line + (household_size - 1) * extra_person_amount
  
  # Track both eligibility and benefit amounts
  qualified_programs = c()
  benefit_amounts = list()
  
  # SNAP benefits calculation
  max_snap = if(household_size == 1) {
    291 * 12  # Convert to annual
  } else if(household_size == 2) {
    535 * 12
  } else if(household_size == 3) {
    766 * 12
  } else if(household_size == 4) {
    973 * 12
  } else {
    (973 + (household_size - 4) * 188) * 12
  }
  
  if (annual_income <= (1.3 * poverty_line)) {
    snap_amount = max(0, max_snap - (0.3 * annual_income))
    qualified_programs = c(qualified_programs, "SNAP (Food Stamps)")
    benefit_amounts$snap = snap_amount
  }
  
  # Medicaid calculation
  # NOTE: This $500/person value is a PLACEHOLDER.
  if (annual_income <= (1.38 * poverty_line)) {
    qualified_programs = c(qualified_programs, "Medicaid")
    benefit_amounts$medicaid = 500 * household_size * 12  # Convert to annual
  }
  
  # Section 8
  if (annual_income <= (0.5 * poverty_line)) {
    qualified_programs = c(qualified_programs, "Priority Section 8 Housing")
    # Estimate housing benefit (30% of income rule)
    estimated_rent = 1200 * 12  # PLACEHOLDER annual market rent
    family_contribution = annual_income * 0.3
    benefit_amounts$section8 = max(0, estimated_rent - family_contribution)
  }
  
  # Job training programs
  if (annual_income < 25000) {
    qualified_programs = c(qualified_programs, "Job Training Programs")
    # PLACEHOLDER value of job training program
    benefit_amounts$job_training = 300 * 12  # Convert to annual value
  }
  
  # PLACEHOLDER EITC calculation (actual calculation is more complex)
  if (annual_income > 0 && annual_income <= 17640) {
    qualified_programs = c(qualified_programs, "Earned Income Tax Credit")
    eitc_annual = min(3995, annual_income * 0.15)
    benefit_amounts$eitc = eitc_annual
  }
  
  # Calculate total annual benefits
  total_annual = sum(unlist(benefit_amounts))
  
  return(list(
    eligible_programs = qualified_programs,
    annual_benefits = benefit_amounts,
    total_annual = total_annual
  ))
}

#Summary of Benefits Printing Function
print_benefits_summary <- function(income, household_size) {
  results = check_benefits(income, household_size)
  
  cat("\nSummary of Benefits\n")
  cat("Income: $", format(income, big.mark=","), "/year\n", sep="")
  cat("Household size:", household_size, "\n")
  cat("-----------------------\n")
  
  cat("\nEligible Benefits:\n")
  if (length(results$eligible_programs) > 0) {
    for(program in results$eligible_programs) {
      cat("* ", program, "\n")
    }
    
    cat("\nEstimated Annual Benefits:\n")
    for(benefit_name in names(results$annual_benefits)) {
      cat(sprintf("- %s: $%.2f\n", 
                  toupper(benefit_name), 
                  results$annual_benefits[[benefit_name]]))
    }
    cat(sprintf("\nTotal Estimated Annual Benefits: $%.2f\n", 
                results$total_annual))
  } else {
    cat("No eligible programs at this income level\n")
  }
}

# Generate plot data function
get_benefits_data <- function(incomes, household_size) {
  benefits_data = map_dfr(incomes, function(inc) {
    results = check_benefits(inc, household_size)
    tibble(
      income = inc,
      annual_benefit = results$total_annual,
      num_programs = length(results$eligible_programs)
    )
  })
  return(benefits_data)
}

#Input levels
test_household_size = 1
test_income = c(5000, 15000, 19000, 22000, 30000, 35000)

# Generate a plot showing benefits vs income
ggplot(chart_data, aes(x = income)) +
  geom_line(aes(y = annual_benefit/10000, color = "Annual Benefits (thousands)")) +  # Divided by 10000 for proper scaling
  geom_line(aes(y = num_programs, color = "Number of Programs")) +
  scale_y_continuous(
    name = "",
    breaks = 0:5,
    sec.axis = sec_axis(
      trans = ~.*10000,  # Multiply by 10000 to show actual annual amounts
      name = "",
      labels = scales::dollar_format()
    )
  ) +
  scale_x_continuous(
    name = "Yearly Income ($)", 
    labels = scales::dollar_format()
  ) +
  scale_color_manual(
    values = c("Annual Benefits (thousands)" = "darkblue", "Number of Programs" = "darkred"),
    name = "Metrics"
  ) +
  theme_minimal() +
  labs(
    title = "Benefits Eligibility and Amount by Income Level",
    subtitle = "Red line: Number of eligible programs | Blue line: Annual benefits (in thousands of dollars)"
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size=14, face="bold"),
    axis.title.y.left = element_text(color = "darkred"),
    axis.title.y.right = element_text(color = "darkblue")
  )

# Test printouts
for(i in test_income) {
  print_benefits_summary(i, test_household_size)
}