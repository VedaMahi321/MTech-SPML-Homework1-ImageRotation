# Homework 1 - Image Rotation using Interpolation

## 📌 Overview
This project demonstrates the implementation of **image rotation by 30°** using three interpolation techniques:
1. **Nearest Neighbor Interpolation**
2. **Bilinear Interpolation**
3. **Bicubic Interpolation**

Additionally, the results are compared with MATLAB's built-in `imrotate` function.  
The project includes manual calculations, MATLAB implementation, and experimental results.

---

## 🛠️ Files Included
- `Homework1_ImageRotation_Report.docx` → Detailed assignment report with manual calculations, explanations, and results.
- `rotation_code.m` → MATLAB script implementing the interpolation methods.
- `test.jpg` → Sample test image used for rotation.
- `results/` → Output images obtained after rotation.
  - Nearest Neighbor result
  - Bilinear result
  - Bicubic result
  - MATLAB built-in comparison

---

## 📖 Methodology
- The input image is rotated by **30°**.
- For each interpolation method:
  - Mapping of output pixel to input pixel coordinates is performed.
  - Interpolated values are calculated based on the nearest, linear, or cubic neighbors.
- Manual calculations are provided for a sample pixel to illustrate the interpolation process.
- A comparison is made between custom implementation and MATLAB’s built-in function.

---

## 📊 Results
- **Nearest Neighbor**: Fast, but produces blocky/jagged edges.  
- **Bilinear**: Smoother results, but may blur fine details.  
- **Bicubic**: Best visual quality, though more computationally expensive.  
- **MATLAB Built-in**: Matches closely with Bicubic in quality.  

---

## 🚀 How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/Homework1-ImageRotation.git
   cd Homework1-ImageRotation
