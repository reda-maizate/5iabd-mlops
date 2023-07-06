import streamlit as st

st.sidebar.markdown("Models")

st.title("Models")

models = [
    "Model 1",
    "Model 2",
    "Model 3"
]

selected_model = st.sidebar.selectbox("Select a model", models)

if selected_model == "Model 1":
    st.write("Details")
    st.write("Description")
elif selected_model == "Model 2":
    st.write("Details")
    st.write("Description")
elif selected_model == "Model 3":
    st.write("Details")
    st.write("Description")