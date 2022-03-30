# MLBD Project: Milestones 3 + 4

## Dataset
Please download all `.csv.gz` files under `/data/raw/` before executing any file in the repository.<br>
The files can be found here: https://drive.google.com/drive/u/2/folders/1JqRUY8_OsxbAxksN-Exsp9jkSgdQNIUZ <br>
The description of the dataset can be found here: https://docs.google.com/document/d/19QDuE4fZmWkntPhYmw5P-8UlQwE_cRGE5f3vC9HQR3s/edit

## Milestone 03 (not graded) - Research question selection
**Deadline: April 4th, 23:59**

We will provide a list of possible research questions and you must choose which one you will focus on and propose ideas and approaches on how you could go about solving it. This milestone is not graded, but it is mandatory for you to submit your ideas. The TAs will schedule individual slots with each team and discuss your plan and approaches, so this is an opportunity for you to get feedback.

**Classtime Questions**:<br>
Predicting student reflection responses from their session interactions
Predicting student performance across sessions (using social_user_id) over a specific attribute (i.e. language of the class, teacher_id, question topics)
Propose a question of your own

**Lernnavi Questions**:<br>
How much are the users learning? (knowledge tracing on topics)<br>
Predicting user motivation and retention. E.g., dropout or long pauses prediction, level checks prediction (self-supervised learning)<br>
How are the users using the platform? (time-series clustering)<br>
Predicting level check performance based on past behavior.<br>
Propose a question of your own

We suggest that you narrow down the question to specify the cohort and themes. For example, in Lernnavi, focusing on Math topics (excluding german topics) or chosing users that started using the platform after January 2021.

In this milestone, you will have to:
- Select your research question
- Describe your data preprocessing strategy
- Describe your modeling methodology
- Describe your evaluation strategy
- (Optional) Ask any questions you have about your project!

[Submit your M3 Form](https://forms.gle/dGSSnyUB6n1XGjAS8)

## Milestone 04 - Results from the research question
Deadline: May 2nd, 23:59

You will design and implement your machine-learning pipeline according to the selected research questions and your exploratory analysis. As part of this process, for instance, you will need to decide which machine-learning approach would be the most suitable for your goals, how your data needs to be pre-processed before being used in the machine-learning approach, which features will be used as inputs for your approach according to the dataset, and so on.<br>
What you will need to do:<br>
- Design your machine-learning approach (e.g., input modeling, feature extraction, model architecture).
- Implement your machine-learning approach.

You can then run more extensive experiments on the selected dataset. Based on the experimental plan, you need to decide the evaluation protocol (e.g., the evaluation method, the metrics to monitor, the training-test activities you will run) and apply this protocol on your machine-learning approach, fed with data from the dataset you selected at the beginning. The different experiments should be run in such a way that they provide results for answering the research questions defined in the first weeks. Once a test is run, for instance, tables and visualizations that summarize the results for your experiment should be prepared. Based on the results, you might need to refine your machine-learning approach, so that its performance will improve along runs.<br>
What you will need to do:
- Define an evaluation protocol to be run to assess the performance of your approach.
- Run extensive experiments according to your research questions and goals.
- Prepare tables and visualizations summarizing the results needed to answer the research question.

For Milestone 04 (M4), you will be required to submit the current results that you have obtained for the selected research question:
<br>please submit a short report (~2 pages) and the code (in a Github repository).

[Create + submit your M4 repository and report (Github Classroom)](https://classroom.github.com/a/GtkOc_e5)
