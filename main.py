import streamlit as st
from openai_helper import get_answer

st.title("InfinitiHacks -: NexaThon")

question = st.text_input("Question:")

if question:
    answer = get_answer(question)
    st.text("Answer:")
    st.write(answer)