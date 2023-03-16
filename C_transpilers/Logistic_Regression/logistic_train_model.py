def build_model():
    import pandas as pd
    from sklearn.linear_model import LogisticRegression
    import joblib
    df = pd.read_csv('maintenance_predictive.csv')
    X = df[['vibration_db', 'age']]
    y = df['has_break_three_month_later']
    model = LogisticRegression()
    model.fit(X, y)
    joblib.dump(model, "logistic_regression.joblib")


build_model()
