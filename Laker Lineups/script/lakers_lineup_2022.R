### Visualizing the Lakers Starting Lineups

# import libraries
library(tidyverse)
library(plyr)

# import dataset (from Basketball-Reference.com; https://www.basketball-reference.com/teams/LAL/2022_start.html)
df = read.csv("data/Lakers_starting_lineups_2022.csv")

# create subset dataframe called "lineup"
lineup = df[ , c("G","Win.Loss","Starter.1","Starter.2","Starter.3","Starter.4","Starter.5")]

# Extend lineup table
lineup.long = gather(lineup, key = A.order, value = Player, -c(G,Win.Loss))
lineup.long = arrange(lineup.long, G, Player)

# Plot 
ggplot(lineup.long) + 
  geom_tile(aes(G, reorder(Player, desc(Player)), fill = Win.Loss), color = "white", size = 1) + 
  scale_x_continuous(breaks = seq(from=2, to=82, by=2)) + 
  scale_fill_manual(values = c("#552583", "#FDB927")) + 
  theme_minimal() + 
  labs(title = "LA Lakers Starting Lineups",
       subtitle = "2021-2022 NBA Season",
       caption = "Data from Basketball-Reference.com",
       x = "Game Number",
       y = NULL) + 
  guides(col=guide_legend("Win/Loss"))


# Count lineup combinations
combos = count(lineup, vars = c("Starter.1","Starter.2","Starter.3","Starter.4","Starter.5"))
combos = arrange(combos, desc(freq))
