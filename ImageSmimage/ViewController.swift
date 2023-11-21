import UIKit

class ViewController: UIViewController {
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let initialHeight = UIScreen.main.bounds.height * 0.43

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
        setupScrollView()
    }

    func setupImageView() {
        imageView.frame = CGRect(
            x: .zero,
            y: .zero,
            width: view.bounds.width,
            height: initialHeight
        )
        imageView.image = UIImage(named: "1.png")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }

    func setupScrollView() {
        let contentRect = CGRect(
            origin: .zero,
            size: CGSize(
                width: UIScreen.main.bounds.width,
                height: 2 * UIScreen.main.bounds.height
            )
        )

        let contentView = UIView(frame: contentRect)
        scrollView.addSubview(contentView)

        view.addSubview(scrollView)
        scrollView.contentSize = contentRect.size
        scrollView.delegate = self
        scrollView.frame = CGRect(
            x: .zero,
            y: initialHeight,
            width: view.bounds.width,
            height: view.bounds.height - initialHeight
        )

        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let moveY = scrollView.contentOffset.y
        let currentY = scrollView.frame.minY - moveY - initialHeight

        if currentY > 0 {
            scrollView.frame =  CGRect(
                x: .zero,
                y: scrollView.frame.minY - moveY,
                width: scrollView.frame.width,
                height: scrollView.frame.height + moveY
            )

            self.imageView.frame = CGRect(
                x: .zero,
                y: .zero,
                width: self.imageView.frame.width,
                height: self.imageView.frame.height - moveY
            )
        } else {
            scrollView.frame =  CGRect(
                x: .zero,
                y: scrollView.frame.minY - moveY,
                width: scrollView.frame.width,
                height: scrollView.frame.height
            )

            self.imageView.frame = CGRect(
                x: .zero,
                y: imageView.frame.minY - moveY,
                width: self.imageView.frame.width,
                height: self.imageView.frame.height
            )
        }
        scrollView.contentOffset = .zero
        scrollView.setNeedsLayout()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollEnded()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollEnded()
        }
    }

    func scrollEnded() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.imageView.frame = CGRect(
                x: .zero,
                y: .zero,
                width: view.bounds.width,
                height: initialHeight
            )

            self.scrollView.frame = CGRect(
                x: .zero,
                y: initialHeight,
                width: view.bounds.width,
                height: view.bounds.height - initialHeight
            )

            scrollView.contentOffset = .zero
        }
    }
}
