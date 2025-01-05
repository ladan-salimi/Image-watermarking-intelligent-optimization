# NewMethod

This repository contains the implementation of a watermarking algorithm using evolutionary optimization techniques. The algorithm processes two input images: a cover image and a watermark image, and embeds the watermark into the cover image.

## Features

- **Image Watermarking**: Embeds a watermark into a cover image.
- **Optimization**: Uses a differential evolution-based algorithm to optimize the embedding process.
- **Performance Metrics**: Calculates PSNR (Peak Signal-to-Noise Ratio) for both the watermarked image and the extracted watermark.
- **Visualization**: Displays the cover image, watermarked image, disorganized watermark, and extracted watermark for comparison.

## Input

- `cover.jpg`: The cover image (used as the base image for embedding the watermark).
- `cameraman.jpg`: The watermark image (to be embedded into the cover image).

## Output

- `Watermarked.bmp`: The resulting image with the embedded watermark.
- `extracted.bmp`: The extracted watermark after processing.
- Performance metrics (`PSNR` values) for both the watermarked image and the extracted watermark.

## How It Works

1. **Initialization**:
   - Converts input images to grayscale and normalizes them.
   - Generates an initial population for optimization.

2. **Embedding**:
   - Embeds the watermark into the cover image using optimized parameters.
   - Measures the quality of embedding using PSNR.

3. **Optimization**:
   - Implements differential evolution to minimize cost functions.
   - Updates population based on mutation, crossover, and selection.

4. **Visualization**:
   - Displays the results, including:
     - Original cover image
     - Watermarked image
     - Disorganized original watermark
     - Extracted watermark

5. **Saving Results**:
   - Saves the watermarked image and the extracted watermark.
   - Saves the best solution and the calculated PSNR values.

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repository-name.git
   cd your-repository-name
