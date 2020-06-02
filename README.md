## Inferring Point Cloud Quality via Graph Similarity

# Abstract: 
Objective quality estimation of media content plays a vital role in vast applications. Though numerous metrics have been successfully devised for 2D image or video, it still lacks of a counterpart for emerging 3D point clouds with unstructured and sparsely distributed points. We propose the GraphSIM – an objective metric to accurately predict the subjective quality of point cloud with superimposed geometry and color impairments. Motivated by the facts that human vision system is more sensitive to the high spatial-frequency components (e.g., contours, edges), and weighs more to the local structural variations rather individual point intensity, we first extract geometric keypoints by resampling the reference point cloud geometry information to form the object skeleton; we then construct local graphs centered at these keypoints for both reference and distorted point clouds, followed by collectively aggregating color gradient moments (e.g., zeroth, first, and second) that are derived between all other points and centered keypoint in the same local graph for significant feature similarity (a.k.a., local significance) measurement; Final similarity index is obtained by pooling the local graph significance across all color channels and by averaging across all graphs. Our GraphSIM is validated using two large and independent point cloud assessment datasets that involve a wide range of impairments (e.g., re-sampling, compression, additive noise), reliably demonstrating the state-of-the-art performance for all distortions with noticeable gains in predicting the subjective mean opinion score (MOS), compared with those point-wise distance-based metrics adopted in standardization reference software. Ablation studies have further shown that GraphSIM is generalized to various scenarios with consistent performance by examining its key modules and parameters. Models and associated materials will be made to public at https://njuvision.github.io/GraphSIM or http://smt.sjtu.edu.cn/papers/GraphSIM.

### Markdown

1. Resampling generation 

```markdown
Demo_fast_make.m

### Markdown
2. GraphSIM
```markdown
GraphSIM.m


**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/NJUVISION/GraphSIM/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
