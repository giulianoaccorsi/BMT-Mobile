from flask import render_template, request, current_app, url_for, flash, redirect
from . import main
from flask_login import login_required, current_user
from app import db
from app.models import User, Ad
from app.main.forms import AdForm
from app.main.utils import admin_required


@main.route("/")
def index():
    return render_template("auth/login.html")


@main.route("/panel", methods=["GET", "POST"])
@login_required
def homepage():

    return render_template("main/panel.html")


@main.route("/users/edit/<int:id>", methods=["GET", "POST"])
@login_required
def edit_user(id):
    user = User.query.get_or_404(id)
    if request.method == "POST":
        name = request.form["name"]
        email = request.form["email"]
        try:
            user.full_name = name
            user.email = email
            user.set_password(request.form["password"])
            db.session.commit()
            flash("Usuário editado com sucesso!", "success")
        except:
            db.session.rollback()
            flash("Falha na alteração do usuário", "error")
        finally:
            db.session.close()
            return redirect(url_for('main.homepage'))

    return render_template(
        "main/user.html",
        action="Edit",
        user=user,
        title="Editar usuário",
    )


@main.route("/users/delete/<int:id>", methods=["GET", "POST"])
@login_required
def delete_user(id):
    user = User.query.get_or_404(id)
    db.session.delete(user)
    db.session.commit()
    flash("Usuário deletada com sucesso!", "success")
    return redirect(url_for("main.homepage"))


@main.route('/ads', methods=["GET"])
@login_required
def show_ads():

    page = request.args.get("page", 1, type=int)

    ads = Ad.query.order_by(Ad.top.desc()).paginate(page, current_app.config["PAGINATION"], False)

    next_url = (
        url_for("main.show_ads", page=ads.next_num) if ads.has_next else None
    )
    prev_url = (
        url_for("main.show_ads", page=ads.prev_num) if ads.has_prev else None
    )

    return render_template("main/new-ads.html", title="Anúncios", ads=ads.items, next_url=next_url, prev_url=prev_url)


@main.route('/ads/add', methods=['GET', 'POST'])
@login_required
def add_ads():
    form = AdForm()
    if form.validate_on_submit():
        ad = Ad(
            user_id=current_user.id,
            top=form.top.data,
            address=form.address.data,
            description=form.description.data,
            img_url=form.img_url.data,
            for_sale=form.for_sale.data,
            price=form.price.data,
            city=form.city.data,
            district=form.district.data,
            telephone=form.telephone.data,
            state=form.state.data
        )
        db.session.add(ad)
        db.session.commit()

        flash('Anúncio criado com sucesso!')
        return redirect(url_for('main.show_ads'))

    return render_template("main/ad.html", title="Anúncios", form=form, creating_ad=True)


@main.route('/ads/edit/<int:id>', methods=['GET', 'POST'])
@login_required
def edit_ads(id):
    ad = Ad.query.get_or_404(id)
    form = AdForm(obj=ad)

    if form.validate_on_submit():
        ad.top = form.top.data
        ad.address = form.address.data
        ad.description = form.description.data
        ad.img_url = form.img_url.data
        ad.for_sale = form.for_sale.data
        ad.price = form.price.data
        ad.city = form.city.data
        ad.district = form.district.data
        ad.telephone = form.telephone.data
        ad.state = form.state.data
        db.session.commit()
        flash('Anúncio editado com sucesso!')

        return redirect(url_for('main.show_ads'))

    form.top.data = ad.top
    form.address.data = ad.address
    form.description.data = ad.description
    form.img_url.data = ad.img_url
    form.for_sale.data = ad.for_sale
    form.price.data = ad.price
    form.city.data = ad.city
    form.district.data = ad.district
    form.state.data = ad.state
    form.telephone.data = ad.telephone

    return render_template('main/ad.html', form=form, ad=ad, title="Editar anúncio")


@main.route('/ads/delete/<int:id>', methods=['GET', 'POST'])
@login_required
def delete_ads(id):
    ad = Ad.query.get_or_404(id)
    db.session.delete(ad)
    db.session.commit()
    flash("Recurso deletado com sucesso!")
    return redirect(url_for("main.show_ads"))
