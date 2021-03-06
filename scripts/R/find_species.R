source('maxent_recover.R')

# Load all data
positive_cells <- readRDS("../../resources/glossy_data_frame.rds")[c('lat', 'lon')]
all_cells <- readRDS("../../resources/nh_data_frame.rds")

# Load raster for cellId calulcations
raster <- raster("../../resources/bio7_13.tif")

# Calculate cell ids
positive_cells$cell <- cellFromRaster(positive_cells$lon, positive_cells$lat, raster)
all_cells$cell <- cellFromRaster(all_cells$lon, all_cells$lat, raster)

rm(raster)

positive_cells$lat <- NULL
positive_cells$lon <- NULL

positive_cell_freqs <- positive_cells %>% count(cell)
positive_cell_freqs$y <- 1

labeled <- left_join(all_cells, positive_cell_freqs, by = 'cell')
# labeled[c('cell', 'lat', 'lon')] <- NULL # We don't need the cell id anymore nor the coordintates

labeled$y[is.na(labeled$y)] <- 0
labeled$n[is.na(labeled$n)] <- 0

# Create assumed distribution

# Normalize features
feature_columns <- !names(labeled) %in% c('n', 'y', 'cell', 'lat', 'lon')
labeled[feature_columns] <- apply(labeled[feature_columns], 2, rescale)

#write.csv(labeled, '../../resources/labeled.csv')

# Normalized original distribution
pi_base <- labeled$n / sum(labeled$n)

# Extract lambdas from original distribution
lambda_base <- maxent(as.matrix(labeled[feature_columns]), pi_base)

# Select a subset
sample_size <- 10000
small_set <- labeled[1:sample_size,]

# Generate more positive sample points
pi_small_real <- softmax(as.matrix(small_set[feature_columns]), lambda_base)
small_samples <- rmultinom(1, size = 1000, prob = pi_small_real)[,1]

# Active learning

## Sample a random sequence for incremental selection

random_order <- sample.int(sample_size)

random_result <- array(NA, sample_size)

for (i in 1:sample_size) {
  # Baseline method: Selecting samples in random order
  random_result[i] <- sum(small_samples[random_order[1:i]])
}

# Discussion

## Plot results

ggplot() + geom_line(aes(x = seq.int(sample_size), y = random_result))



